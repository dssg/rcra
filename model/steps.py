from drain import step, model, util
from epa.model.transform import EpaTransform
import logging
from itertools import product

metrics = [
    {'metric':'baseline'},
    {'metric':'count'},
    {'metric':'precision', 'dropna':True, 'k':100},
    {'metric':'precision', 'dropna':True, 'k':200},
    {'metric':'precision', 'dropna':True, 'k':500},
    {'metric':'precision', 'dropna':True, 'k':1000},
    {'metric':'auc'},
]

violation_args = dict(
        outcome_expr='violation_epa > 0',  # need > 0 since violation_epa can be null
        train_query='evaluation_epa', 
        evaluation=False
)

evaluation_args = dict(
    outcome_expr='evaluation_epa > 0', 
    train_query='active_today or evaluation or (handler_age < 365)', 
    evaluation=True
)

forest = {'__class_name__':['sklearn.ensemble.RandomForestClassifier'], 
        'n_estimators':[500],
        'criterion':['entropy'],
        'balanced':[True],
        'max_features':['sqrt'],
        'n_jobs':[-1]}

logit = {'__class_name__':['sklearn.linear_model.LogisticRegression'],
        'penalty':['l1'], 'C':[.01]}

svm = {'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01], 'penalty':['l1'], 'dual':[False]}

forest_search = {'__class_name__':['sklearn.ensemble.RandomForestClassifier'], 
        'n_estimators':[500],
        'criterion': ['entropy', 'gini'],
        'max_features':['sqrt','log2'],
        'n_jobs':[-1]}

logit_search = {'__class_name__':['sklearn.linear_model.LogisticRegression'],
        'penalty':['l1','l2'], 'C':[.01,.1,1,10]}

svm_search = [{'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01,.1,1], 'penalty':['l2'], 'dual':[True,False]},
        {'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01,.1,1], 'penalty':['l1'], 'dual':[False]}]

def violation():
    return models(transform_search= dict(train_years=2, **violation_args), estimator_search=forest)

def violation_best():
    return models(transform_search= dict(train_years=2, **violation_args), estimator_search=forest) + \
            models(transform_search= violation_args, estimator_search=svm) + \
            models(transform_search=violation_args, estimator_search=logit)

def violation_train_years():
    return models(transform_search= {'outcome':['violation_epa'],
            'train_years':range(1,6)
            }, estimator_search=forest)

def violation_region():
    return models(transform_search= {'outcome':['violation_epa'],
            'region':range(1,11),
            'train_years': [5]
            }, estimator_search=forest)

def violation_logit():
    return models(transform_search= {'outcome':['violation_epa']},
            estimator_search = logit_search)

def violation_forest():
    return models(transform_search= {'outcome':['violation_epa']},
            estimator_search = forest_search)

def violation_svm():
    return models(transform_search= {'outcome':['violation_epa']},
            estimator_search = svm_search[0]) + \
           models(transform_search= {'outcome':['violation_epa']},
            estimator_search = svm_search[1])

def violation_all():
    return violation_logit() + violation_forest() + violation_svm() + violation_train_years() + violation_region()

def evaluation():
    return models(transform_search=dict(train_years=4, **evaluation_args), estimator_search=forest)

def calibrated_evaluation():
    return calibrated_models(transform_search={'outcome':['evaluation_epa'], 'train_years':[4], 'year':[2012],
    }, estimator_search = forest)

def evaluation_and_violation():
    es = evaluation()
    vs = violation()

    evs = []
    for e in es:
        e_year = e.inputs[1].year
        e.get_input('transform').__name__ = 'e_transform'
        e.get_input('estimator').__name__ = 'e_estimator'
        e.get_input('y').__name__ = 'e_y'
        for v in vs:
            v_year = v.inputs[1].year
            if e_year == v_year:
                ev = model.PredictProduct(inputs= [e,v], 
                    inputs_mapping=['evaluation', 'violation'], 
                    target=True)
                evs.append(ev)
    return evs

def calibrated_violation():
    return calibrated_models(transform_search= {'outcome':['violation_epa'], 'year':[2012], 'train_years': [2],
            }, estimator_search=forest)

def calibrated_evaluation_and_violation():
    e = calibrated_evaluation()[0]
    v = calibrated_violation()[0]
    ve = model.PredictProduct(inputs= [e,v], inputs_mapping=['inspection', 'violation'], target=True)
    ve.get_input('transform').__name__ = 'transform2'
    ve.get_input('estimator').__name__ = 'estimator2'
    ve.get_input('y').__name__ = 'y2'
    return [ve]


def evaluation_best():
    return models(transform_search= {'outcome':['evaluation_epa']}, 
                estimator_search=forest) + \
            models(transform_search= {'outcome':['evaluation_epa']}, 
                estimator_search=svm) + \
            models(transform_search= {'outcome':['evaluation_epa']}, 
                estimator_search=logit)

def models(transform_search={}, estimator_search={}):
    steps = []
    transform_search = util.merge_dicts(dict(
        train_years = [3],
        year=range(2011,2014+1) + [2016]
    ), transform_search)

    for transform_args, estimator_args in product(
            util.dict_product(transform_search), 
            util.dict_product(estimator_search)):
        logging.info('%s, %s' % (transform_args, estimator_args))

        transform = EpaTransform(month=1, day=1, 
                handlers = {'facility': ['1y', 'all'], 
                #        'state':['1y','2y','5y']
                },
                icis = {'facility': ['5y', 'all']},
                rmp = {'facility': ['5y', 'all']},
                investigations = {'facility': ['1y', '5y', 'all'], 
         #               'state':['1y','2y','5y']
                },
                name='transform', **transform_args)

        estimator = step.Construct(name='estimator', **estimator_args)

        y = model.FitPredict(inputs=[estimator, transform], name='y', target=True)
        steps.append(y)

    return steps


def calibrated_models(transform_search={}, estimator_search={}):
    steps = []
    transform_search = util.merge_dicts(dict(
        train_years = [3],
        year=range(2012,2014+1) + [2016]
    ), transform_search)

    for transform_args, estimator_args in product(
            util.dict_product(transform_search), 
            util.dict_product(estimator_search)):
        logging.info('%s, %s' % (transform_args, estimator_args))

        transform = EpaTransform(month=1, day=1, 
                handlers = {'facility': ['1y', 'all']},
                icis = {'facility': ['5y', 'all']},
                rmp = {'facility': ['5y', 'all']},
                investigations = {'facility': ['1y', '5y', 'all']},#, 'state':['1y']},
                name='transform', **transform_args)
        
        estimator = step.Construct(name='estimator', **estimator_args)
        calibrator =  step.Construct('sklearn.calibration.CalibratedClassifierCV', cv=10,
                inputs=[estimator], inputs_mapping=['base_estimator'], name='calibrator')

        y = model.FitPredict(inputs=[calibrator, transform], name='y', target=True)
        steps.append(y)

    return steps
