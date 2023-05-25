import { TodoType } from "../../types";

export const Todo = ({ id, description }: TodoType) => (
    <li>
        {id}. {description}
    </li>
)