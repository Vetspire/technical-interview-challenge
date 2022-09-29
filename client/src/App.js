import {
  BrowserRouter as Router,
  Route,
  useParams,
  Routes,
  Link
} from "react-router-dom";
import { useQuery, gql } from '@apollo/client';
import './App.css';
import { SERVER_URL } from './constants';

const GET_BREEDS = gql`
  query GetBreeds {
    breeds(limit: 10) {
      id
      name
    }
  }
`;

const GET_BREED = gql`
  query GetBreed($id: Int!) {
    breed(id: $id) {
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

  return (
    <ul>
    {data.breeds.map(({ id, name }) => (
      <li key={id}>
        <Link to={`/${id}`}>{name}</Link>
        <br />
      </li>
    ))}
    </ul>
  );
}

function BreedView() {
  const { id } = useParams();

  const { loading, error, data } = useQuery(GET_BREED, {
    variables: { id: parseInt(id, 10) }
  });

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  const breed = data.breed;

  return (<div>
    <Link to="/">Back to breeds list</Link>
    <h3>{breed.name}</h3>
    <img height="250" alt={breed.name} src={`${SERVER_URL}/${breed.imageUrl}`} />
    <br />
  </div>)
}

function App() {
  return (
    <div>
      <h2> Vetsprite Challenge</h2>
      <Router>
        <Routes>
            <Route path="/" element={<BreedsList />} />
            <Route path="/:id" element={<BreedView />} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
