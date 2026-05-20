const Appointment = require('../models/Appointment');
const Patient = require('../models/Patient');
const Doctor = require('../models/Doctor');

// Get all appointments with optional status filter
exports.getAllAppointments = async (req, res) => {
  const filter = req.query.status ? { status: req.query.status } : {};
  const appointments = await Appointment.find(filter)
    .populate('patient', 'name')
    .populate('doctor', 'name specialization');
  res.render('appointments/index', { appointments, status: req.query.status || '' });
};

// Show book appointment form with patients and doctors list
exports.getAddAppointment = async (req, res) => {
  const patients = await Patient.find();
  const doctors = await Doctor.find();
  res.render('appointments/form', { appointment: null, patients, doctors });
};

// Save new appointment to database
exports.postAddAppointment = async (req, res) => {
  try {
    await Appointment.create(req.body);
    req.flash('success', 'Appointment booked successfully');
    res.redirect('/appointments');
  } catch (err) {
    req.flash('error', 'Error booking appointment');
    res.redirect('/appointments/add');
  }
};

// Show edit form with existing appointment data
exports.getEditAppointment = async (req, res) => {
  const appointment = await Appointment.findById(req.params.id);
  const patients = await Patient.find();
  const doctors = await Doctor.find();
  res.render('appointments/form', { appointment, patients, doctors });
};

// Update appointment record in database
exports.postEditAppointment = async (req, res) => {
  try {
    await Appointment.findByIdAndUpdate(req.params.id, req.body);
    req.flash('success', 'Appointment updated successfully');
    res.redirect('/appointments');
  } catch (err) {
    req.flash('error', 'Error updating appointment');
    res.redirect('/appointments');
  }
};

// Cancel/Delete appointment from database
exports.deleteAppointment = async (req, res) => {
  await Appointment.findByIdAndDelete(req.params.id);
  req.flash('success', 'Appointment cancelled');
  res.redirect('/appointments');
};

// Generate printable appointment slip
exports.printAppointment = async (req, res) => {
  try {
    const appointment = await Appointment.findById(req.params.id)
      .populate('patient')
      .populate('doctor');
    
    if (!appointment) {
      req.flash('error', 'Appointment not found');
      return res.redirect('/appointments');
    }
    
    if (!appointment.patient || !appointment.doctor) {
      req.flash('error', 'Patient or Doctor data missing');
      return res.redirect('/appointments');
    }
    
    res.render('appointments/print', { appointment });
  } catch (err) {
    console.error('PRINT ERROR:', err.message);
    req.flash('error', 'Error loading print slip');
    res.redirect('/appointments');
  }
};