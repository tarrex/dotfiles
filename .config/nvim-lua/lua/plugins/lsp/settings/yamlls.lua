return {
  settings = {
    schemes = {
      ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
      ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = '/docker-compose*.y?(a)ml',
      ['https://json.schemastore.org/github-action.json'] = '/action.y?(a)ml',
      ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
    }
  }
}
