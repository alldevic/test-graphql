import { ApolloClient, InMemoryCache, gql } from "@apollo/client";

export const client = new ApolloClient({
  uri: "http://localhost:3000/graphql",
  cache: new InMemoryCache(),
});

export const GET_TODOS = gql`
  {
    todos {
      id
      description
    }
  }
`;

export const CREATE_TODO = gql`
  mutation createTodoMutation($todo: CreateTodoInput!) {
    createTodo(createTodoInput: $todo) {
      id
      description
    }
  }
`;
