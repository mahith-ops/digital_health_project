const prisma = require('../config/prisma');
const bcrypt = require('bcryptjs');
const generateToken = require('../utils/generateToken');

class UserService {
  // Register a new user
  async register(email, password, name) {
    // Check if user exists
    const existingUser = await prisma.user.findUnique({
      where: { email }
    });

    if (existingUser) {
      throw new Error('User already exists');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create user
    const user = await prisma.user.create({
      data: {
        email,
        password: hashedPassword,
        name
      }
    });

    return {
      id: user.id,
      email: user.email,
      token: generateToken(user.id)
    };
  }

  // Login user
  async login(email, password) {
    const user = await prisma.user.findUnique({
      where: { email }
    });

    if (!user) {
      throw new Error('Invalid credentials');
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      throw new Error('Invalid credentials');
    }

    return {
      id: user.id,
      email: user.email,
      token: generateToken(user.id)
    };
  }
}

module.exports = new UserService();