const express = require('express');
const cors = require('cors');
const passport = require('passport');
require('dotenv').config();

const sequelize = require('./config/database'); // Make sure sequelize is imported
const authRoutes = require('./routes/authRoute');

const app = express();

app.use(express.json());
app.use(cors({ origin: process.env.CORS_ORIGIN || '*', credentials: true }));
app.use(passport.initialize());

// Mount routes BEFORE starting the server
app.use('/auth', authRoutes);

const PORT = process.env.PORT || 3000;

(async () => {
  try {
    await sequelize.authenticate();
    console.log('Connected to PostgreSQL database.');

    await sequelize.sync({ alter: true });  // Sync models with DB

    app.listen(PORT, () => {
      console.log(`Server listening on port ${PORT}`);
    });
  } catch (error) {
    console.error('Unable to connect to the database:', error);
  }
})();

module.exports = app;
