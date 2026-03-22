const userService = require('../services/userService');

// REGISTER
exports.register = async (req, res) => {
  try {
    const { email, password, name } = req.body;

    const userData = await userService.register(email, password, name);

    res.status(201).json(userData);
  } catch (error) {
    if (error.message === 'User already exists') {
      return res.status(400).json({ message: error.message });
    }
    res.status(500).json({ message: "Server error" });
  }
};

// LOGIN
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const userData = await userService.login(email, password);

    res.json(userData);
  } catch (error) {
    if (error.message === 'Invalid credentials') {
      return res.status(400).json({ message: error.message });
    }
    res.status(500).json({ message: "Server error" });
  }
};