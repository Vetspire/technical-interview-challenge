const express = require('express');
const path = require('path');
const fs = require('fs').promises;
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;
app.use(cors());

let breedMap = new Map();
breedMap.set('Affenpinscher', 'affenpinscher.jpg');
breedMap.set('Border Collie', 'border_collie.jpg');
breedMap.set('Boxer', 'boxer.jpg');
breedMap.set('Cocker Spaniel', 'cocker_spaniel.jpg');
breedMap.set('English Bulldog', 'english_bulldog.jpg');
breedMap.set('Great Dane', 'great_dane.jpg');
breedMap.set('Irish Terrier', 'irish_terrier.jpg');
breedMap.set('Norwich Terrier', 'norwich_terrier.jpg');
breedMap.set('Pomeranian', 'pomeranian.jpg');
breedMap.set('Shetland Sheepdog', 'shetland_sheepdog.jpg');

/*
 * The getBreedList api returns
 *    and returns the name of the corresponding image file.
 *    All images are assumed to be in the same directory.
 */
app.get('/api/getBreedList', async (req, res) => {
  try {
    const breedList = Array.from(breedMap.keys());
    // console.log(breedList);
    res.json({ breedList });
  } catch (error) {
    console.error('Error fetching breed list:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

/*
 * The getImage api takes a text dog breed from the breedMap
 *    and returns the name of the corresponding image file as a string. 
 * 
 *    All images are assumed to be in the same directory.
 */
app.get('/api/getImage', (req, res) => {
  try {
    const selectedValue = (breedMap.has(req.query.value) ? breedMap.get(req.query.value) : '');
    res.json({ imageUrl: selectedValue});
  } catch (error) {
    console.error('Error fetching image:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
