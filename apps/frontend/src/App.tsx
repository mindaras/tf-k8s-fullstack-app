import { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [count, setCount] = useState<number | string>(0);

  const getCount = async () => {
    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/count`);
      const { data } = await response.json();
      setCount(data);
    } catch (e) {
      setCount((e as Error)?.message);
    }
  };

  useEffect(() => {
    getCount();
  }, []);

  const increase = async () => {
    try {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/count`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ count: Number(count) + 1 }),
      });
      const { data } = await response.json();
      setCount(data);
    } catch (e) {
      setCount((e as Error)?.message);
    }
  };

  return (
    <div>
      <div>Count: {count}</div>
      <button onClick={increase}>Increase</button>
    </div>
  );
}

export default App;
