import { A, createAsync, query } from "@solidjs/router";
import { For, Suspense } from "solid-js";
import { db } from "~/db/db";
import { Nodes } from "~/db/schema";

const getNodes = query(async () => {
  "use server";
  return db.select().from(Nodes);
}, "users");

export const route = {
  preload: () => getNodes(),
};

export default function Home() {
  const nodes = createAsync(() => getNodes());

  return (
    <main class="text-gray-700 p-4 flex flex-col items-center">
      <h1 class="max-6-xs text-6xl text-sky-700 font-thin uppercase my-16">
        Hello world!
      </h1>
      <Suspense fallback="loading...">
        <ul class="text-indigo-200 text-xl list-disc">
          <For each={nodes()}>{(el) => <li>{el.title}</li>}</For>
        </ul>
      </Suspense>
    </main>
  );
}
