import { getCacheClient } from "@db/cache";
import { RequestHandler, Router } from "express";

const getCount: RequestHandler = async (req, res) => {
  try {
    const cache = await getCacheClient();
    const count = await cache.get("count");
    res.json({ data: Number(count || 0) });
  } catch (err) {
    res.status(500).json({ message: "Failed to process the request" });
  }
};

const setCount: RequestHandler = async (req, res) => {
  try {
    const cache = await getCacheClient();
    await cache.set("count", req.body.count);
    res.json({ data: req.body.count });
  } catch (err) {
    res.status(500).json({ message: "Failed to process the request" });
  }
};

const counterApi = Router().get("/", getCount).post("/", setCount);

export { counterApi };
