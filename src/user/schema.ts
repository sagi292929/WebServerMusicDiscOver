export const userTypeDefs = `#graphql
  enum UserRole {
    User
    Admin
  }

  type User {
    Id: Int!
    name: String!
    role: UserRole!
  }

  extend type Query {
    getUser(id: Int!): User
    getUsers: [User!]!
    userExists(name: String!): Boolean!
  }

  type Mutation {
    saveUser(name: String!, password: String!): User!
    login(name: String!, password: String!): String
  }
`;
