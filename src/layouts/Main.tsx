import { JSX } from "solid-js";

export default function Main(props: { children: JSX.Element }) {
    return (
        <>
            {props.children}
        </>
    );
}