const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const User = require('../models/User');

// GET Login
router.get('/login', (req, res) => {
  res.render('auth/login');
});

// POST Login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user || !(await user.matchPassword(password))) {
      req.flash('error', 'Invalid email or password');
      return res.redirect('/auth/login');
    }
    req.session.user = { id: user._id, name: user.name, role: user.role };
    res.redirect('/');
  } catch (err) {
    req.flash('error', 'Something went wrong');
    res.redirect('/auth/login');
  }
});

// GET Signup
router.get('/signup', (req, res) => {
  res.render('auth/signup');
});

// POST Signup
router.post('/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existing = await User.findOne({ email });
    if (existing) {
      req.flash('error', 'Email already registered');
      return res.redirect('/auth/signup');
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    await User.create({ name, email, password: hashedPassword });
    req.flash('success', 'Account created! Please login');
    res.redirect('/auth/login');
  } catch (err) {
    req.flash('error', err.message);
    res.redirect('/auth/signup');
  }
});

// GET Profile
router.get('/profile', (req, res) => {
  if (!req.session.user) return res.redirect('/auth/login');
  res.render('auth/profile', { user: req.session.user });
});

// GET Change Password page
router.get('/change-password', (req, res) => {
  if (!req.session.user) return res.redirect('/auth/login');
  res.render('auth/change-password');
});

// POST Change Password
router.post('/change-password', async (req, res) => {
  try {
    const { oldPassword, newPassword } = req.body;
    const user = await User.findById(req.session.user.id);
    const isMatch = await user.matchPassword(oldPassword);
    if (!isMatch) {
      req.flash('error', 'Old password is incorrect');
      return res.redirect('/auth/change-password');
    }
    user.password = await bcrypt.hash(newPassword, 10);
    await user.save();
    req.flash('success', 'Password changed successfully');
    res.redirect('/auth/profile');
  } catch (err) {
    req.flash('error', 'Something went wrong');
    res.redirect('/auth/change-password');
  }
});

// GET Logout
router.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/auth/login');
});

module.exports = router;