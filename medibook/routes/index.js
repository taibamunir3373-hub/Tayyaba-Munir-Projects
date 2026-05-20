const express = require('express');
const router = express.Router();
const { isAuth } = require('../middleware/auth');
const Patient = require('../models/Patient');
const Doctor = require('../models/Doctor');
const Appointment = require('../models/Appointment');

router.get('/landing', (req, res) => {
  res.render('landing');
});

router.get('/', isAuth, async (req, res) => {
  const patientCount = await Patient.countDocuments();
  const doctorCount = await Doctor.countDocuments();
  const appointmentCount = await Appointment.countDocuments();
  const pendingCount = await Appointment.countDocuments({ status: 'pending' });
  const confirmedCount = await Appointment.countDocuments({ status: 'confirmed' });
  const cancelledCount = await Appointment.countDocuments({ status: 'cancelled' });
  const recentAppointments = await Appointment.find()
    .populate('patient', 'name')
    .populate('doctor', 'name specialization')
    .sort({ createdAt: -1 })
    .limit(5);

  const monthLabels = [];
  const monthData = [];
  for (let i = 5; i >= 0; i--) {
    const d = new Date();
    d.setMonth(d.getMonth() - i);
    const start = new Date(d.getFullYear(), d.getMonth(), 1);
    const end = new Date(d.getFullYear(), d.getMonth() + 1, 0);
    const count = await Appointment.countDocuments({ createdAt: { $gte: start, $lte: end } });
    monthLabels.push(start.toLocaleString('default', { month: 'short', year: '2-digit' }));
    monthData.push(count);
  }

  res.render('index', {
    title: 'Dashboard',
    patientCount, doctorCount, appointmentCount,
    pendingCount, confirmedCount, cancelledCount,
    recentAppointments, monthLabels, monthData
  });
});

module.exports = router;