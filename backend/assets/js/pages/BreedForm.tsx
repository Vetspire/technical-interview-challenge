import React, { useRef, useState } from 'react'


function BreedForm() {
  return (
    <form action="/api/breeds" method="post" encType="multipart/form-data" name="breed" className="max-w-xl mx-auto border-2 px-5">
      <h2 className="text-3xl text-gray-800 font-semibold my-2">Add a Breed</h2>
      <div className="mb-6">
        <label htmlFor="breedName" className="block mb-2 text-sm font-medium text-gray-900">
          Name
        </label>
        <input type="text" id="breedName" name="breedName" className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 5"></input>
      </div>
      <div className="mb-6">
        <label htmlFor="breedDescription" className="block mb-2 text-sm font-medium text-gray-900">
          Description
        </label>
        <textarea name="breedDescription" id="breedDescription" placeholder="What's the deal with these dogs?" rows={2} className="block p-2 5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500"></textarea>
      </div>
      <div className="mb-6">
        <label htmlFor="breedImage" className="block mb-2 text-sm font-medium text-gray-900" >
          Upload Image
        </label>
        <input id="breedImage" name="breedImage" type="file" className="block w-full text-sm py-1.5 px-1.5 text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 focus:outline-none"></input>
        <div className="mt-1 text-sm text-gray-500" >
          Choose a rad picture of this dog breed!
        </div>
      </div>
      <div className="mb-6">
        <button type="submit" className="py-2.5 px-7 text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-300 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200">
          Submit
        </button>
      </div>
    </form>
  )
}

export default BreedForm;