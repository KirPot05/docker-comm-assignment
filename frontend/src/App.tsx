import { useEffect, useState } from "react";

const API_BASE = import.meta.env.VITE_API_BASE || "/api";

export default function App() {
  const [data, setData] = useState(null);
  const [err, setErr] = useState("");

  useEffect(() => {
    // Iteration 1: browser calls host-published API
    fetch(`${API_BASE}/predict`)
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then(setData)
      .catch((e) => setErr(String(e)));
  }, []);

  return (
    <div style={{ fontFamily: "system-ui", padding: 24 }}>
      <h2>React → FastAPI (Docker)</h2>

      <p>
        Frontend: <code>http://localhost:3000</code>
        <br />
        API: <code>{API_BASE}</code>
      </p>

      {err && <pre style={{ color: "crimson" }}>{err}</pre>}
      {data ? <pre>{JSON.stringify(data, null, 2)}</pre> : <p>Loading…</p>}
    </div>
  );
}
