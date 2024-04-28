import { NextResponse } from "next/server";
import { exec } from "child_process";

export const GET = async (req) => {
    // Respond immediately to keep the connection alive
    const initialResponse = new NextResponse(
        JSON.stringify({ message: "Processing request..." }),
        {
            status: 200,
            "Content-Type": "application/json",
            "Connection": "keep-alive" // Ensure connection stays open
        }
    );

    exec("nginx -v", async (error, stdout, stderr) => {
        if (!error && !stderr && stdout.includes("nginx")) {
            // Nginx is installed
            return new NextResponse(
                JSON.stringify({ message: "Nginx is installed." }),
                {
                    status: 200,
                    "Content-Type": "application/json"
                }
            );
        } else {
            // Nginx is not installed, run installation commands
            exec("apt update && apt install nginx -y", (error, stdout, stderr) => {
                if (error) {
                    console.error("Error installing Nginx:", error);
                    return initialResponse;
                }
                if (stderr) {
                    console.error("Error installing Nginx:", stderr);
                    return initialResponse;
                }
                console.log("Nginx installed successfully.");
                return new NextResponse(
                    JSON.stringify({ message: "Nginx installed successfully." }),
                    {
                        status: 200,
                        "Content-Type": "application/json"
                    }
                );
            });
        }
    });

    return initialResponse;
};
