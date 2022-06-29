import { faker } from '@faker-js/faker'
import init from '../utils/auth'
import insertUsers from './user'

const configSeed = async () => {
  faker.setLocale('ko')
  await init()
}

const main = async () => {
  await configSeed()
  insertUsers(10)
}

main()
