import { NextResponse } from "next/server";
import si from "systeminformation";

export const GET = async (req) => {
  // const cpu = await si.cpu();
  // const system = await si.system();
  const valueObject = {
    cpu: "*",
    osInfo: "platform, release",
    system: "model, manufacturer",
    mem: " total, free, used",
    memLayout: "size, bank, type, clockSpeed,partNum, serialNum, manufacturer",
    osInfo: "platform, distro, release, serial, uefi",
  };

  const disk = await si.diskLayout();
  const wifi = await si.wifiNetworks();

  const general = await si.get(valueObject);

  return new NextResponse(
    JSON.stringify({ wifi, disk, general }),
    { status: 200, "Content-Type": "application/json" } // 401 Internal Server Error
  );
};
