import { useState, useEffect } from 'react';
import TextField from '@mui/material/TextField';
import { ImageList } from '@mui/material';

import BreedCard from '../../components/breedCard/breedCard';
import BreedInfoService from '../../services/BreedInfoService';
import Breed from '../../models/breed';

import './home.css';

function Home() {
    const [upToDateData, setUpToDateData] = useState<boolean>(false);
    const [breedList, setBreedList] = useState<Breed[]>([]);
    const [breedSearch, setBreedSearch] = useState<string>("");

    useEffect(() => {
        const fetchBreeds = async () => BreedInfoService.getAllBreeds().then(data => setBreedList(data.breeds));
    
        fetchBreeds();
        setUpToDateData(true);
    }, [upToDateData]);

    const handleNewBreed = (event: any) => {
        event.preventDefault();
        const formData = new FormData();
        formData.append('dog_image', event.target[1].files[0]);
      
        fetch('/dogs/'+event.target[0].value, {
          method: 'POST',
          body: formData
        })
        .then(response => response.json())
        .then(data => {
          setUpToDateData(false);
        })
        .catch(error => {
          console.error(error);
        })
    };

    return (
        <div className="Home">
            <form onSubmit={handleNewBreed}>
                <input type="text" id="breed" name="breed" placeholder="Enter dog name"/>
                <input type="file" id="dog_image" name="dog_image"/>
                <input type="submit" value="Add breed"/>
            </form>
            <TextField 
                id="breedFilter" 
                label="Dog Breed" 
                variant="standard" 
                value={breedSearch}
                onChange={(ev) => setBreedSearch(ev.target.value)}/>
            <ImageList variant="masonry" cols={5}>
                {breedList.filter(breed => breed.name.toLowerCase().includes(breedSearch.toLowerCase())).map((breed, _)=>{
                    return <BreedCard breed={breed}/>
                })}
            </ImageList>
        </div>
    );
}

export default Home;
