import { config } from "@config/config";
import { createClient } from "redis";

const { user, password, host, port } = config.cache;
const client = createClient({
  url: `redis://${user}:${password}@${host}:${port}`,
});

client.on("error", (err) => console.error("Redis error:", err));

const getCacheClient = async () => {
  if (!client.isReady) {
    await client.connect();
  }

  return client;
};

export { getCacheClient };
