import { Client } from "@elastic/elasticsearch";
import { config } from "./config";

export const elasticsearch = new Client({
  node: config.elasticsearch.node,
  ...(config.elasticsearch.username && config.elasticsearch.password
    ? {
        auth: {
          username: config.elasticsearch.username,
          password: config.elasticsearch.password,
        },
      }
    : {}),
});
