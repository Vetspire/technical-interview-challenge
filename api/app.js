var createError = require('http-errors');
var express = require('express');
var path = require('path');
var fs = require('fs');
var cookieParser = require('cookie-parser');
const cors = require('cors')
var logger = require('morgan');
var { graphqlHTTP } = require('express-graphql');
var { buildSchema } = require('graphql');

var dogsRouter = require('./routes/dogs');

var schema = buildSchema(`
  type Query {
    breeds: [Breed]
  }

  type Breed {
    name: String
    filename: String
  }
`);

const convertFilenameToBreed = (filename) => {
  return filename.split(".")[0].split("_").map(word => word[0].toUpperCase() + word.substring(1)).join(" ");
}

var root = { 
  breeds: () => {
    return fs.readdirSync("public/images/")
             .map(filename => { return {name: convertFilenameToBreed(filename), filename: 'images/'+filename}});
  } 
};

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.resolve(__dirname, '../my-app/build')));
app.use(cors());
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.use('/dogs', dogsRouter);

app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true,
}));


app.use(function(req, res, next) {
  next(createError(404));
});

app.use(function(err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  res.status(err.status || 500);
});

app.get('*', (req, res) => {
  res.sendFile(path.resolve(__dirname, '../my-app/build', 'index.html'));
});


app.listen(3000, () => {
  console.log(`Example app listening on port 3000`)
});

module.exports = app;
