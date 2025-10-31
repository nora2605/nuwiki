import { Router } from "@solidjs/router";
import { FileRoutes } from "@solidjs/start/router";
import { Suspense } from "solid-js";
import "./app.css";
import Main from "./layouts/Main";

export default function App() {
  return (
    <Router
      root={(props) => (
        <Main>
          <Suspense>{props.children}</Suspense>
        </Main>
      )}
    >
      <FileRoutes />
    </Router>
  );
}
