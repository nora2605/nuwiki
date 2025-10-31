import nuwikiConfig from "./nuwiki.config";

export default {
  dialect: "sqlite",
  schema: "./src/db/schema.ts",
  out: "./drizzle/migrations/",
  dbCredentials: {
    url: nuwikiConfig.db_file
  },
};
