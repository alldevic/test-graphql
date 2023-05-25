import { useRef } from "react"
import { useMutation } from "@apollo/client"

import { CREATE_TODO, GET_TODOS } from "../../graphql"
import { TodoType } from "../../types"

export const CreateTodo = () => {
    const todoRef: any = useRef({})
    const [createTodo] = useMutation(CREATE_TODO, {
        refetchQueries: [
            {query: GET_TODOS}, // DocumentNode object parsed with gql
            'GetTodos' // Query name
        ],
    })

    const handleSubmit = async (event: any) => {
        event.preventDefault();

        const todo: TodoType = { description: event.target[0].value }

        await createTodo({ variables: { todo }})
    }

    return (
        <div>
            <form ref={todoRef} onSubmit={handleSubmit}>
                <input type="text" name="descriptin" />

                <button type="submit">Save</button>
            </form>
        </div>
    )
}