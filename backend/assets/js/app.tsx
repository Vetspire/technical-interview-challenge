import React from 'react';
import { Outlet } from 'react-router-dom';

import NavBar from './components/NavBar';

function App() {
  return (
    <div className="app">
      <NavBar />
      <main className="mt-12 mx-auto px-4 max-w-screen-xl lg:px-8">
        {/* Layout based on https://www.floatui.com/components/cards/ */}
        <Outlet />
      </main>
    </div>
  )
}

export default App;