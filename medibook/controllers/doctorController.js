const Doctor = require('../models/Doctor');
const Appointment = require('../models/Appointment');

// Get all doctors with search
exports.getAllDoctors = async (req, res) => {
  const search = req.query.search || '';
  const doctors = await Doctor.find({
    $or: [
      { name: { $regex: search, $options: 'i' } },
      { specialization: { $regex: search, $options: 'i' } }
    ]
  });
  res.render('doctors/index', { doctors, search });
};

// Show add doctor form
exports.getAddDoctor = (req, res) => {
  res.render('doctors/form', { doctor: null });
};

// Add new doctor
exports.postAddDoctor = async (req, res) => {
  try {
    await Doctor.create(req.body);
    req.flash('success', 'Doctor added successfully');
    res.redirect('/doctors');
  } catch (err) {
    req.flash('error', 'Error adding doctor');
    res.redirect('/doctors/add');
  }
};

// Show edit form
exports.getEditDoctor = async (req, res) => {
  const doctor = await Doctor.findById(req.params.id);
  res.render('doctors/form', { doctor });
};

// Update doctor
exports.postEditDoctor = async (req, res) => {
  try {
    await Doctor.findByIdAndUpdate(req.params.id, req.body);
    req.flash('success', 'Doctor updated successfully');
    res.redirect('/doctors');
  } catch (err) {
    req.flash('error', 'Error updating doctor');
    res.redirect('/doctors');
  }
};

// Delete doctor
exports.deleteDoctor = async (req, res) => {
  await Doctor.findByIdAndDelete(req.params.id);
  req.flash('success', 'Doctor deleted');
  res.redirect('/doctors');
};

// Doctor profile page
exports.getDoctorProfile = async (req, res) => {
  const doctor = await Doctor.findById(req.params.id);
  const appointments = await Appointment.find({ doctor: req.params.id })
    .populate('patient', 'name phone')
    .sort({ date: -1 });
  const total = appointments.length;
  const confirmed = appointments.filter(a => a.status === 'confirmed').length;
  const pending = appointments.filter(a => a.status === 'pending').length;
  res.render('doctors/profile', { doctor, appointments, total, confirmed, pending });
};