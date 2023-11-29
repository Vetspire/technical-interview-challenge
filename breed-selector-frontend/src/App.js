import React, { useState, useEffect } from 'react';

const BreedSelector = () => {
  const [selectedValue, setSelectedValue] = useState('');
  const [imageUrl, setImageUrl] = useState('');
  const [breedList, setBreedList] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Fetch the list of available breeds
    const fetchBreedList = async () => {
      try {
        const response = await fetch('http://localhost:3001/api/getBreedList');
        if (!response.ok) {
          throw new Error(`Failed to fetch breed list. Status: ${response.status}`);
        }

        const data = await response.json();
        setBreedList(data.breedList);

        // Set the selected value to the first breed in the list by default
        if (data.breedList.length > 0) {
          setSelectedValue(data.breedList[0]);
        }
      } catch (error) {
        console.error('Error fetching breed list:', error);
        setError('Failed to fetch breed list. Please try again.');
      }
    };

    fetchBreedList();
  }, []);

  useEffect(() => {
    const fetchImage = async () => {
      try {
        const response = await fetch(`http://localhost:3001/api/getImage?value=${selectedValue}`);
        if (!response.ok) {
          throw new Error(`Failed to fetch image. Status: ${response.status}`);
        }

        const data = await response.json();
        setImageUrl(data.imageUrl);
      } catch (error) {
        console.error('Error fetching image:', error);
        setError('Failed to fetch image. Please try again.');
      }
    };

    fetchImage();
  }, [imageUrl, selectedValue]);

  const handleSelectChange = (event) => {
    setError(null); // Clear any previous error when the user selects a new image
    setSelectedValue(event.target.value);
  };

  return (
    <div>
      {error && <p style={{ color: 'red' }}>{error}</p>}

      <label htmlFor="breed-selector">
      Select a dog breed: 
      </label>
      <select id="breed-selector" onChange={handleSelectChange} value={selectedValue}>
        {breedList.map((image, index) => (
          <option key={index} value={image}>
            {image}
          </option>
        ))}
      </select>

      <div id="image-container" >
        {imageUrl ? (
          <img src={'./images/'+imageUrl} alt={selectedValue} style={{maxWidth:`500px`, maxHeight:`500px`}}/>
        ) : (
          <p>No image selected</p>
        )}
      </div>
    </div>
  );
};

export default BreedSelector;
