const { DataTypes } = require('sequelize');
const sequelize = require('./config/db');

const User = sequelize.define('User', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  googleId: { type: DataTypes.STRING, allowNull: false, unique: true },
  displayName: DataTypes.STRING,
  email: DataTypes.STRING,
  photo: DataTypes.STRING,
  createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
},{
    timestamps: false,
    tableName: 'users',
  });
module.exports = User;
