CREATE TABLE `articles` (
	`nodeId` integer NOT NULL,
	`nwtext` text NOT NULL,
	`cover` integer,
	FOREIGN KEY (`nodeId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`cover`) REFERENCES `files`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `atoms` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`content` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `categories` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `categories_name_unique` ON `categories` (`name`);--> statement-breakpoint
CREATE TABLE `category_properties` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`categoryId` integer NOT NULL,
	`name` text NOT NULL,
	`type` text NOT NULL,
	`order` integer NOT NULL,
	FOREIGN KEY (`categoryId`) REFERENCES `categories`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `files` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`created` integer,
	`updated` integer,
	`filename` text NOT NULL,
	`hash` text NOT NULL,
	`type` text,
	`post` integer,
	FOREIGN KEY (`post`) REFERENCES `posts`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `files_hash_unique` ON `files` (`hash`);--> statement-breakpoint
CREATE TABLE `node_atoms` (
	`nodeId` integer NOT NULL,
	`atomId` integer NOT NULL,
	FOREIGN KEY (`nodeId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`atomId`) REFERENCES `atoms`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `node_categories` (
	`nodeId` integer NOT NULL,
	`categoryId` integer NOT NULL,
	FOREIGN KEY (`nodeId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`categoryId`) REFERENCES `categories`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `node_properties` (
	`nodeId` integer NOT NULL,
	`categoryPropertyId` integer NOT NULL,
	`value` text NOT NULL,
	FOREIGN KEY (`nodeId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`categoryPropertyId`) REFERENCES `category_properties`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `node_tags` (
	`nodeId` integer NOT NULL,
	`tagId` integer NOT NULL,
	FOREIGN KEY (`nodeId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`tagId`) REFERENCES `tags`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `nodes` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`created` integer,
	`updated` integer,
	`title` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `post_tags` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`postId` integer NOT NULL,
	`tagId` integer NOT NULL,
	`bbox` bbox,
	`parentId` integer,
	FOREIGN KEY (`postId`) REFERENCES `posts`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`tagId`) REFERENCES `tags`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`parentId`) REFERENCES `post_tags`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `posts` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL
);
--> statement-breakpoint
CREATE TABLE `relationship_types` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`color` text,
	`symmetric` integer NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `relationship_types_name_unique` ON `relationship_types` (`name`);--> statement-breakpoint
CREATE TABLE `relationships` (
	`leftId` integer NOT NULL,
	`rightId` integer NOT NULL,
	`type` integer NOT NULL,
	FOREIGN KEY (`leftId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`rightId`) REFERENCES `nodes`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`type`) REFERENCES `relationship_types`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `relationships_leftId_rightId_type_unique` ON `relationships` (`leftId`,`rightId`,`type`);--> statement-breakpoint
CREATE TABLE `tags` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`description` text,
	`type` text
);
--> statement-breakpoint
CREATE UNIQUE INDEX `tags_name_unique` ON `tags` (`name`);