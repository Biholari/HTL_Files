import { Router } from "express";
import { AppDataSource } from "../index";
import { User } from "../entities/User";

const authRouter = Router();

// authRouter.post('/login', async (req, res) => {
//   const userRepo = AppDataSource.getRepository(User);
//   const user = await userRepo.findOneBy({ username: req.body.username });
//   if (user && bcrypt.compareSync(req.body.password, user.password)) {
//     const token = jwt.sign({ id: user.id, role: user.role }, 'secret', { expiresIn: '1h' });
//     res.json({ token });
//   } else {
//     res.status(401).json({ message: 'Invalid credentials' });
//   }
// });

export default authRouter;
