import { Card, CardHeader, CardMedia, ImageListItem } from '@mui/material';
import Breed from '../../models/breed';
import './breedCard.css';

interface BreedCardProps {
    breed: Breed
}

function BreedCard(props:BreedCardProps) {
  return (
    <ImageListItem key={props.breed.name}>
      <Card>
        <CardHeader title={props.breed.name} />
        <CardMedia
          component="img"
          height="194"
          image={props.breed.filename}
          alt={props.breed.name}
        />
      </Card>
    </ImageListItem>
  );
}

export default BreedCard;
