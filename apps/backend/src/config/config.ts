import dotenv from "dotenv";

dotenv.config();

const env = process.env as { [key: string]: string };

const config = {
  app: {
    PORT: env.PORT,
  },
  cache: {
    user: env.CACHE_USER,
    password: env.CACHE_PASSWORD,
    host: env.CACHE_HOST,
    port: parseInt(env.CACHE_PORT),
  },
};

export { config };
