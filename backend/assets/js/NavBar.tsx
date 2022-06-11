import React from "react";

import { Link } from "react-router-dom";

function NavBar() {
  return (
    <nav className="w-full flex flex-wrap justify-betweeen px-4 py-4 bg-gray-100 text-gray-500 hover:text-gray-700 focus:text-gray-700 shadow-lg navbar navbar-expand-lg navbar-light">
      <Logo />
      {BreadCrumbs()}
    </nav>
  )
}

function BreadCrumbs() {
  return (
    <ol className="inline-flex items-center space-x-1 md:space-x-3">
      <li className="inline-flex items-center">
        <div className="flex items-center">
          <Link to="/" className="ml-1 text-sm font-medium text-gray-700 hover:text-gray-900 md:ml-2 dark:text-gray-400 dark:hover:text-white">Dogonomicon</Link>
        </div>
      </li>
      <li className="inline-flex items-center">
        <div className="flex items-center">
          <BreadCrumbArrow />
          <Link to="breeds" className="ml-1 text-sm font-medium text-gray-700 hover:text-gray-900 md:ml-2 dark:text-gray-400 dark:hover:text-white">Breeds</Link>
        </div>
      </li>
      <li className="inline-flex items-center">
        <div className="flex items-center">
          <BreadCrumbArrow />
          <span className="ml-1 text-sm font-medium text-gray-500 md:ml-2 dark:text-gray-400">Blue Heeler</span>
        </div>
      </li>
    </ol>
  )
}

function Logo() {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" enableBackground="new 0 0 512 512" viewBox="0 0 512 512"><path d="M214.422,192.451c12.712-53.14-31.288-111.48-33.224-114.01c-1.422-1.857-3.792-2.725-6.076-2.209
		c-2.283,0.511-4.061,2.303-4.554,4.59l-3.897,18.07c-6.724-11.883-12.523-19.568-13.198-20.451
		c-1.422-1.857-3.793-2.725-6.077-2.209c-2.282,0.511-4.061,2.303-4.554,4.59l-24.093,111.71l0.095,0.021v120.468h-0.229v122.895
		h158.304h16.146l-3.948-10.495l-10.082-26.796v-0.26h-0.098l-31.785-84.483h30.575c63.774,0,115.659-51.885,115.659-115.66v-5.771
		H214.422z M179.323,97.148c11.979,19.358,32.761,59.959,22.678,95.303h-15.308c6.418-26.831-1.616-54.984-11.4-76.614
		L179.323,97.148z M151.597,97.148c3.3,5.332,7.267,12.284,11.075,20.285c2.886,6.063,5.673,12.728,8.014,19.764
		c5.787,17.395,8.789,37.02,3.588,55.254h-43.23L151.597,97.148z M275.729,423.915H130.614v-13.551h140.017L275.729,423.915z
		 M266.115,398.364H130.614v-84.483h103.904l-0.166,0.063L266.115,398.364z M277.727,302.34H130.385v-98.348h213.218v31.083h31.499
		C360.187,274.349,322.166,302.34,277.727,302.34z M378.84,223.075h-23.237v-19.083h26.084
		C381.327,210.531,380.355,216.909,378.84,223.075z"/><rect width="22.365" height="20" x="194.065" y="225.98" /></svg>
  )
}

function BreadCrumbArrow() {
  return (
    <svg className="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
      <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd"></path>
    </svg>
  )
}

export default NavBar;