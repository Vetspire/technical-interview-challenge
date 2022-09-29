import { useQuery, gql } from '@apollo/client';
import './App.css';
import { SERVER_URL } from './constants';

const GET_BREEDS = gql`
  query GetBreeds {
    breeds(limit: 10) {
      id
      name
      imageUrl
    }
  }
`;

function BreedsList() {
  const { loading, error, data } = useQuery(GET_BREEDS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return data.breeds.map(({ id, name, imageUrl }) => (
    <div key={id}>
      <h3>{name}</h3>
      <img height="250" alt="location-reference" src={`${SERVER_URL}/${imageUrl}`} />
      <br />
    </div>
  ));
}

function App() {
  return (
    <div>
      <h2>Breeds</h2>
      <br/>
      <BreedsList />
    </div>
  );
}

export default App;
