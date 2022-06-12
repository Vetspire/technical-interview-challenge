import React, { useEffect, useState } from "react";
import { Link, Location, useLocation, useParams } from "react-router-dom";

/**
 * This whole component is a pretty big hack.
 * The goal was to implement functional breadcrumbs without
 * bringing in additional dependencies or getting to crazy with props.
 * 
 * Better solutions (in no particular order):
 *   1. Use a state library like redux
 *   2. Use a context and/or hooks based solution
 *   3. Bring in a library from NPM (like use-react-router-breadcrumbs)
 *   4. Use props
 */

function determineCrumbLevel(currentPath: string): number {
  switch(currentPath) {
    case "/":
      return 0;
    case "/breeds":
      return 1;
    default:
      return 2;
  }
}

function maybeBreedName(state): string | undefined {
  return state?.breedName
}

/**
 * Leaving breedId and breedName as nullable throughout this file
 * isn't great, but it should be alright since they're only used
 * on the BreedDetail page.
 * 
 * If a user navigates via a link on BreedList then breedName will be populated in state.
 * breedId is populated in the route params so it's a safe fallback either way.
 */
interface BreadCrumbState {
  crumbLevel: number,
  breedId?: string,
  breedName?: string
}

function BreadCrumbs() {
  const location = useLocation();
  const params = useParams();
  const [crumbState, setCrumbState] = useState<BreadCrumbState>({crumbLevel: 0});
  useEffect(() => {
    const crumbLevel = determineCrumbLevel(location.pathname);
    const breedId = params?.breedId;
    const breedName = maybeBreedName(location.state);
    setCrumbState({crumbLevel, breedId, breedName});
  }, [location]);

  return (
    <ol className="inline-flex items-center space-x-1 md:space-x-3">
      <Crumb  text="Dogonomicon" to="/" first />
      {crumbState.crumbLevel >= 1 && <Crumb text="Breeds" to="breeds" />}
      {crumbState.crumbLevel >= 2 && <Crumb text={crumbState.breedName || crumbState.breedId || "View Breed"} to={`/breeds/${crumbState.breedId}`} />}
    </ol>
  )
}

interface CrumbProps {
  first?: boolean,
  text: string,
  to: string
}

function Crumb({first = false, text, to}: CrumbProps) {
  return (
    <li className="inline-flex items-center">
      <Link to={to}>
        <div className="flex items-center">
          {!first && <BreadCrumbArrow />}
          <span className="ml-1 text-sm font-medium text-gray-500 md:ml-2 dark:text-gray-400">{text}</span>
        </div>
      </Link>
    </li>
  )
}

function BreadCrumbArrow() {
  return (
    <svg className="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
      <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd"></path>
    </svg>
  )
}

export default BreadCrumbs;