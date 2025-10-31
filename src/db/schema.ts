import { customType, foreignKey, int, sqliteTable as table, text, unique } from "drizzle-orm/sqlite-core";

type Bbox = {
  x: number,
  y: number,
  w: number,
  h: number
}

const bbox = customType<{
  data: Bbox,
  driverData: string
}>({
  dataType(_) { return 'bbox' },
  fromDriver(value: string): Bbox {
    let el = value.split(':').map(Number);
    return { x: el[0], y: el[1], w: el[2], h: el[3] };
  },
  toDriver(value: Bbox): string {
    return `${value.x}:${value.y}:${value.w}:${value.h}`;
  }
});

export const Nodes = table("nodes", {
  id: int().primaryKey({ autoIncrement: true }),
  created: int({ mode: 'timestamp' }),
  updated: int({ mode: 'timestamp' }),
  title: text().notNull()
})

export const RelationshipTypes = table("relationship_types", {
  id: int().primaryKey({ autoIncrement: true }),
  name: text().notNull().unique(),
  color: text(),
  symmetric: int({ mode: 'boolean' }).notNull()
})

export const Relationships = table("relationships", {
  leftId: int().notNull().references(() => Nodes.id),
  rightId: int().notNull().references(() => Nodes.id),
  type: int().notNull().references(() => RelationshipTypes.id)
}, (table) => [
  unique().on(table.leftId, table.rightId, table.type)
])

export const Categories = table("categories", {
  id: int().primaryKey({ autoIncrement: true }),
  name: text().notNull().unique()
})

export const NodeCategories = table("node_categories", {
  nodeId: int().notNull().references(() => Nodes.id),
  categoryId: int().notNull().references(() => Categories.id)
})

export const CategoryProperties = table("category_properties", {
  id: int().primaryKey({ autoIncrement: true }),
  categoryId: int().notNull().references(() => Categories.id),
  name: text().notNull(),
  type: text({ enum: ["section", "text", "number", "boolean", "date", "place"] }).notNull(),
  order: int().notNull()
})

export const NodeProperties = table("node_properties", {
  nodeId: int().notNull().references(() => Nodes.id),
  categoryPropertyId: int().notNull().references(() => CategoryProperties.id),
  value: text().notNull()
})

export const Posts = table("posts", {
  id: int().primaryKey({ autoIncrement: true })
})

export const Files = table("files", {
  id: int().primaryKey({ autoIncrement: true }),
  created: int({ mode: 'timestamp' }),
  updated: int({ mode: 'timestamp' }),
  filename: text().notNull(),
  hash: text().notNull().unique(),
  type: text({ enum: ["image", "video", "audio", "document"] }),
  post: int().references(() => Posts.id)
})

export const Articles = table("articles", {
  nodeId: int().notNull().references(() => Nodes.id),
  nwtext: text().notNull(),
  cover: int().references(() => Files.id)
})

export const Tags = table("tags", {
  id: int().primaryKey({ autoIncrement: true }),
  name: text().notNull().unique(),
  description: text(),
  type: text({ enum: ["meta", "creator", "node", "general"] })
})

export const NodeTags = table("node_tags", {
  nodeId: int().notNull().references(() => Nodes.id),
  tagId: int().notNull().references(() => Tags.id)
})

export const PostTags = table("post_tags", {
  id: int().primaryKey({ autoIncrement: true }),
  postId: int().notNull().references(() => Posts.id),
  tagId: int().notNull().references(() => Tags.id),
  bbox: bbox(),
  parentId: int()
}, (table) => [
  foreignKey({
    columns: [table.parentId],
    foreignColumns: [table.id]
  })
])

export const Atoms = table("atoms", {
  id: int().primaryKey({ autoIncrement: true }),
  content: text().notNull(),
  //time: nwtime(),
  //place: nwplace()
})

export const NodeAtoms = table("node_atoms", {
  nodeId: int().notNull().references(() => Nodes.id),
  atomId: int().notNull().references(() => Atoms.id)
})