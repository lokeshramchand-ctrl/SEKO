const { OAuth2Client } = require('google-auth-library');
const prisma = require('../prisma'); // Your initialized Prisma client
const User = require('../models/User');

const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

exports.googleTokenLogin = async (req, res) => {
  try {
    const { idToken } = req.body;
    const ticket = await client.verifyIdToken({
      idToken,
      audience: process.env.GOOGLE_CLIENT_ID,
    });

    const payload = ticket.getPayload();
   
    // Upsert user in PostgreSQL (Prisma)
    const user = await prisma.user.upsert({
      where: { googleId: payload.sub },
      update: {
        displayName: payload.name,
        email: payload.email,
        photo: payload.picture,
      },
      create: {
        googleId: payload.sub,
        displayName: payload.name,
        email: payload.email,
        photo: payload.picture,
      },
    });

    res.json({ success: true, user });
  } catch (err) {
    res.status(401).json({ error: 'Invalid token', details: err.message });
  }
};
