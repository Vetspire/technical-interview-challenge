import React from 'react';

interface GreeterProps {
  name: string;
}

const Greeter: React.FC<GreeterProps> = (props: GreeterProps) => {
  const name = props.name;
  return (
    <div className="flex justify-center">
        <div className="rounded-lg shadow-lg bg-white max-w-sm">
          <div className="p-6">
            <h5 className="text-gray-900 text-xl font-medium mb-2">Hello, {name}!</h5>
            <p className="text-gray-700 text-base mb-4">
              Tailwind and React are working.
            </p>
          </div>
        </div>
      </div>
  )
}

export default Greeter;