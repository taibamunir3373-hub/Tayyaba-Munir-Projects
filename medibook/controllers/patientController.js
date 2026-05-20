const Patient = require('../models/Patient');

// Get all patients with optional search by name
exports.getAllPatients = async (req, res) => {
  const search = req.query.search || '';
  const patients = await Patient.find({
    name: { $regex: search, $options: 'i' }
  });
  res.render('patients/index', { patients, search });
};

// Show add patient form
exports.getAddPatient = (req, res) => {
  res.render('patients/form', { patient: null });
};

// Save new patient to database
exports.postAddPatient = async (req, res) => {
  try {
    await Patient.create(req.body);
    req.flash('success', 'Patient added successfully');
    res.redirect('/patients');
  } catch (err) {
    req.flash('error', 'Error adding patient');
    res.redirect('/patients/add');
  }
};

// Show edit form with existing patient data
exports.getEditPatient = async (req, res) => {
  const patient = await Patient.findById(req.params.id);
  res.render('patients/form', { patient });
};

// Update patient record in database
exports.postEditPatient = async (req, res) => {
  try {
    await Patient.findByIdAndUpdate(req.params.id, req.body);
    req.flash('success', 'Patient updated successfully');
    res.redirect('/patients');
  } catch (err) {
    req.flash('error', 'Error updating patient');
    res.redirect('/patients');
  }
};

// Delete patient from database
exports.deletePatient = async (req, res) => {
  await Patient.findByIdAndDelete(req.params.id);
  req.flash('success', 'Patient deleted');
  res.redirect('/patients');
};