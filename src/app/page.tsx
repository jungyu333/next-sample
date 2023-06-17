import Image from "next/image";

export default function Home() {
  console.log(process.env.NEXT_PUBLIC_API_URL as string);
  return (
    <>
      <div>Home</div>
      <div>testrdddrrddd</div>
      <div>{process.env.NEXT_PUBLIC_API_URL}</div>
    </>
  );
}
