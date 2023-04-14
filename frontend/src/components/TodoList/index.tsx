import { useQuery } from "@apollo/client";

import { Todo } from '../Todo'

import { GET_TODOS } from "../../graphql";

export const TodoList = () => {
    const { loading, error, data } = useQuery(GET_TODOS);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error : {error.message}</p>;

    return (
        <ul>
            {data.todos.map((todo: any) => (
                <Todo {...todo} key={todo.id} />
            ))}
        </ul>
    )
}