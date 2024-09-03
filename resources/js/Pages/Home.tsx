import { Link } from "@inertiajs/react";

export default function Home() {
  const faleConoscoUrl = route('faleconosco');

  return (
    <div>
      <h1>Teste</h1>
      <Link href={faleConoscoUrl}>Fale Conosco</Link>
    </div>
  );
}
