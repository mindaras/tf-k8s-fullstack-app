import cors from "cors";
import express from "express";
import { config } from "@config/config";
import { counterApi } from "@modules/counter/api";

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/api/count", counterApi);
app.get("/ping", (_, res) => res.send("pong"));
app.listen(config.app.PORT, () =>
  console.log(`Listening on port: ${config.app.PORT}`)
);

export { app };
