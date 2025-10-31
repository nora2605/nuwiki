import Database from 'better-sqlite3';
import { drizzle } from 'drizzle-orm/better-sqlite3';
import nuwikiConfig from '../../nuwiki.config';
import { pushSQLiteSchema } from "drizzle-kit/api"

const sqlite = new Database(nuwikiConfig.db_file);

export const db = drizzle(sqlite);