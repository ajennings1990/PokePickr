extension MainViewCoordinator: MainViewControllerDelegate {
  
  func playButtonWasPressed(_ viewController: MainViewController) {
    let repository = DefaultPokemonInfoRepository()
    let service = DefaultTrainerGameService(pokemonInfoRepository: repository)

    let coordinator = TrainerGameCoordinator(
      selectionTotal: 10,
      trainerGameService: service,
      navigationController: navigationController,
      delegate: self
    )
    start(coordinator: coordinator)
  }
  
}
