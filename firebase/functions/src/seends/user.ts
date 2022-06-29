import { faker } from '@faker-js/faker'
// eslint-disable-next-line import/no-unresolved
import { insertMultipleDoc } from '../utils/functions'

interface User {
  email: string
  displayName: string
  name: string
  googleId: string | null
  createAt: Date
  updateAt: Date
  deleteAt: Date | null
}

const getRandomUser = (): User => {
  return {
    email: faker.internet.email(),
    displayName: faker.internet.userName(),
    name: faker.internet.userName(),
    googleId: null,
    createAt: new Date(),
    updateAt: new Date(),
    deleteAt: null
  }
}

const createUsers = (counts: number): User[] => {
  const users: User[] = []

  Array.from({ length: counts }).forEach(() => {
    users.push(getRandomUser())
  })

  return users
}

const insertUsers = (counts: number) => {
  const users = createUsers(counts)

  insertMultipleDoc<User>(users)
}

export default insertUsers
