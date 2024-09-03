import { Link } from "@inertiajs/react";

export default function FaleConosco() {
  const home = route('home');
    return (
        <div>
            <h1> Teste </h1>
            <Link href={home}>Home</Link>
        </div>
    );
}
