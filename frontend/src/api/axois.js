import axios from "axios";

const API = axios.create({
  baseURL: "http://127.0.0.1:5000", // ton backend FastAPI
  headers: {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
  },
  withCredentials: true,
});

export default API;
