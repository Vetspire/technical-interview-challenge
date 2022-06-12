import React from "react";
import { Link } from "react-router-dom";

function Default() {
  return (
    <Link to="breeds" className="">
      <button type="button" className="py-2.5 px-7 my-2 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-300 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200">
        View Dog Breeds
      </button>
    </Link>
  )
}

export default Default;