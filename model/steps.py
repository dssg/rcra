from drain import step, model
from epa.model.transform import EpaTransform
from itertools import product

metrics = [
    {'metric':'baseline'},
    {'metric':'count'},
    {'metric':'precision', 'dropna':True, 'k':100},
    {'metric':'precision', 'dropna':True, 'k':200},
    {'metric':'precision', 'dropna':True, 'k':500},
    {'metric':'auc'},
]

def calibration():
    steps = []
    for outcome, train_years, n_estimators in product(('violation_epa', 'evaluation_epa'), range(1,5), [500,1000]):
        transform = EpaTransform(month=1, day=1, year=2013, train_years=train_years,
                outcome=outcome,
                handlers = {'facility': ['all']},
                investigations = {'facility': ['1y', '5y'], 'state':['1y']},
                name='transform')

        estimator = step.Construct('sklearn.ensemble.RandomForestClassifier', 
                n_estimators=n_estimators, n_jobs=-1, name='estimator')

        y = model.FitPredict(inputs=[estimator, transform], name='y', target=True)
        metrics1 = model.PrintMetrics(metrics, inputs=[y], target=True)

        calibrator = step.Construct('sklearn.calibration.CalibratedClassifierCV', cv=4, inputs=[estimator], inputs_mapping=['base_estimator'], name='calibrator')

        y_calibrated = model.FitPredict(inputs=[calibrator, transform], name='y_calibrated', target=True)
        metrics2 = model.PrintMetrics(metrics, inputs=[y_calibrated], target=True)

        steps.append(metrics1)
        steps.append(metrics2)

    return steps
