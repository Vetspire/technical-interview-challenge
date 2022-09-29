import {
  BrowserRouter as Router,
  Route,
  useParams,
  Routes,
  Link,
  useNavigate
} from "react-router-dom";
import { useQuery, gql, useMutation } from '@apollo/client';
import './App.css';
import { SERVER_URL } from './constants';
import { useState } from "react";

const GET_BREEDS = gql`
  query GetBreeds {
    breeds(limit: 100) {
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

const ADD_BREED = gql`
  mutation($name: String!, $image: Upload!) {
    addBreed(name: $name, image: $image) {
      id
    }
  }
`

function BreedsList() {
  const { loading, error, data } = useQuery(GET_BREEDS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <div>
      <h3>Breeds</h3>
      <ul>
      {data.breeds.map(({ id, name }) => (
        <li key={id}>
          <Link to={`/${id}`}>{name}</Link>
          <br />
        </li>
      ))}
      </ul>
      <BreedUpload />
    </div>
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

function BreedUpload() {
  const navigate = useNavigate();
  const [mutate, { loading, error }] = useMutation(ADD_BREED);
  const [image, setImage] = useState();
  const [name, setName] = useState('');

  const onUpload = ({ target: { validity, files: [file] }}) => {
    if (validity.valid) setImage(file);
  }
  const onSubmit = async () => {
    const result = await mutate({ variables: { name, image }});
    const id = result.data?.addBreed?.id;

    if (id) navigate(`/${id}`);
  }

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  return (
    <div>
      <h3>Add a new breed</h3>
      <form onSubmit={onSubmit}>
        <label htmlFor="name">Name</label>
        <br />
        <input type="text" required name="name" value={name} onChange={data => setName(data.target.value)} ></input>
        <br />
        <br />
        <label htmlFor="image">Image</label>
        <br />
        <input type="file" required name="image" onChange={onUpload} />
        <br />
        <br />
        <button type="submit">Add breed</button>
      </form>
    </div>
  )
}

function App() {
  return (
    <div>
      <h2>Vetsprite Challenge</h2>
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
