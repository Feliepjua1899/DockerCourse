import axios from "axios";

const URL = import.meta.env.VITE_API || "http://localhost:8000";

console.log("URL permitida backend INFO", URL);
const endpoint = URL + "/info";

export const fetchInfo = () => axios.get(endpoint);